function aux.RegisterSpeedDuelSkillCardCommon()
	
	if aux.speed_skill_reg then return end

	aux.speed_skill_reg = true
	aux.ExiledSpeedDuelSkillCardCount={}
	aux.ExiledSpeedDuelSkillCardCount[0]=0
	aux.ExiledSpeedDuelSkillCardCount[1]=0
	aux.CardAddedBySkill=Group.CreateGroup()
	aux.CardAddedBySkill:KeepAlive()
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetOperation(aux.SpeedDuelExileCard)
	Duel.RegisterEffect(e1,0)

	e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetOperation(aux.SpeedDuelGlobalCheck)
	Duel.RegisterEffect(e1,0)
end
function aux.IsSpeedDuelSkillCard(c)
	return c:GetOriginalCode()>100730000 and c:GetOriginalCode() < 100740000 and not aux.CardAddedBySkill:IsContains(c)
end
function aux.SpeedDuelExileCard(e,tp,eg,ep,ev,re,r,rp)
	if not aux.CheckedIsTag then
		aux.CheckedIsTag = true
		if Duel.GetLP(0) > 8001 then
			aux.IsTag = true
		end
	end
	local g=Duel.GetMatchingGroup(aux.IsSpeedDuelSkillCard,0,LOCATION_EXTRA,LOCATION_EXTRA,nil)
	if g:GetCount()>0 then Duel.Exile(g,REASON_RULE) end
end
function aux.SpeedDuelRegisterTurn(c)
	aux.SpeedDuelSkillRegisterTurn[c]=Duel.GetTurnCount()
end
function aux.SpeedDuelGlobalCheck(e,tp,eg,ep,ev,re,r,rp)
	local p0Lose = false
	local p1Lose = false
	if aux.ExiledSpeedDuelSkillCardCount[0]>1 then p0Lose = true end
	if aux.ExiledSpeedDuelSkillCardCount[1]>1 then p1Lose = true end
	if Duel.IsExistingMatchingCard(aux.IsSpeedDuelSkillCard,0,LOCATION_EXTRA,0,7,nil) then p1Lose = true end
	if Duel.IsExistingMatchingCard(aux.IsSpeedDuelSkillCard,1,LOCATION_EXTRA,0,7,nil) then p0Lose = true end
	if p0Lose then Duel.SetLP(0,0) end
	if p1Lose then Duel.SetLP(1,0) end
	e:Reset()
end
function aux.SpeedDuelMoveCardToFieldCommon(id,c)
	--activate
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetOperation(aux.SpeedDuelMoveCardToFieldCommonOperation)
	e1:SetLabel(id)
	e1:SetLabelObject(c)
	Duel.RegisterEffect(e1,0)
end
function aux.SpeedDuelMoveCardToFieldCommonOperation(e,tp,eg,ep,ev,re,r,rp)
	local id=e:GetLabel()
	tp = e:GetLabelObject():GetOwner()
	local c=Duel.CreateToken(tp,id)
	if (c:IsType(TYPE_MONSTER)) then
		Duel.MoveToField(c,tp,tp,LOCATION_MZONE,POS_FACEUP,true)
	else
		Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	end
	e:Reset()
end

function aux.SpeedDuelMoveCardToDeckCommon(id,c)
	if not aux.Redraw then
		aux.Redraw={}
		aux.Redraw[0]=true
		aux.Redraw[1]=true
	end
	--activate
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetOperation(aux.SpeedDuelMoveCardToDeckCommonOperation)
	e1:SetLabel(id)
	e1:SetLabelObject(c)
	Duel.RegisterEffect(e1,0)
	--activate
	local e2=Effect.GlobalEffect()
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_DRAW)
	e2:SetOperation(aux.SpeedDuelRedraw)
	e2:SetLabelObject(c)
	Duel.RegisterEffect(e2,0)
end
function aux.SpeedDuelMoveCardToDeckCommonOperation(e,tp,eg,ep,ev,re,r,rp)
	local id=e:GetLabel()
	tp = e:GetLabelObject():GetOwner()
	local c=Duel.CreateToken(tp,id)
	Duel.DisableShuffleCheck()
	Duel.SendtoDeck(c,nil,-1,REASON_RULE)
	if c:GetLocation()&LOCATION_DECK then
		aux.Redraw[tp]=false
	end
	aux.CardAddedBySkill:AddCard(c)
	e:Reset()
end
function aux.SpeedDuelRedraw(e,tp,eg,ep,ev,re,r,rp)
	tp = (e:GetLabelObject()):GetOwner()
	if aux.Redraw[tp] then return end
	aux.Redraw[tp]=true
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_HAND,0,nil)
	local g2=Group.CreateGroup()
	local c=g:GetFirst()
	local count=0
	while c do
		local tc=Duel.CreateToken(tp,c:GetOriginalCode())
		g2:AddCard(tc)
		count=count+1
		c=g:GetNext()
	end
	Duel.Exile(g,REASON_RULE)
	Duel.SendtoDeck(g2,nil,-1,REASON_RULE)
	local g3=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_DECK,0,nil)
	g3=g3:RandomSelect(tp,count)
	local c2=g3:GetFirst()
	while c2 do
		local tc2=Duel.CreateToken(tp,c2:GetOriginalCode())
		Duel.SendtoHand(tc2,nil,REASON_RULE)
		c2=g3:GetNext()
	end
	Duel.Exile(g3,REASON_RULE)
	e:Reset()
end