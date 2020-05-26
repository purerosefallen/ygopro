function aux.RegisterSpeedDuelSkillCardCommon()
	
	if aux.speed_skill_reg then return end

	aux.speed_skill_reg = true
	aux.ExiledSpeedDuelSkillCardCount={}
	aux.ExiledSpeedDuelSkillCardCount[0]=0
	aux.ExiledSpeedDuelSkillCardCount[1]=0
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
	return c:GetOriginalCode()>100730000 and c:GetOriginalCode() < 100740000
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

