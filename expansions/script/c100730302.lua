--高速决斗技能-调律
Duel.LoadScript("speed_duel_common.lua")
function c100730302.initial_effect(c)
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetOperation(c100730302.skill2)
	e1:SetLabelObject(c)
	Duel.RegisterEffect(e1,0)
	if not c100730302.UsedLP then
		c100730302.UsedLP={}
		c100730302.UsedLP[0]=0
		c100730302.UsedLP[1]=0
	end
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelReplaceDraw(c,c100730302.skill,c100730302.con,aux.Stringid(100730302,1))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730302.skill(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	if Duel.SelectYesNo(tp,aux.Stringid(100730302,0)) then
		Duel.Hint(HINT_CARD,1-tp,100730302)
		c100730302.UsedLP[tp]=c100730302.UsedLP[tp]+1000
	local g=Duel.SelectMatchingCard(tp,c100730302.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
		Duel.ShuffleDeck(tp)
		Duel.BreakEffect()
		Duel.DiscardDeck(tp,1,REASON_EFFECT)
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_DRAW_COUNT)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_DRAW)
	e1:SetValue(0)
	Duel.RegisterEffect(e1,tp)
	e:Reset()
	end
end

function c100730302.con(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp
		and Duel.GetMatchingGroupCount(c100730302.filter,tp,LOCATION_DECK,0,nil)>0
		and aux.DecreasedLP[tp]-c100730302.UsedLP[tp] >= 1000
end
function c100730302.filter(c)
	return c:IsSetCard(0x1017) and c:IsType(TYPE_TUNER) and c:IsAbleToHand()
end
function c100730302.skill2(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	local g=Group.CreateGroup()
	local c=Duel.CreateToken(tp,9365703)
	g:AddCard(c)
	aux.CardAddedBySkill:AddCard(c)
	c=Duel.CreateToken(tp,95360850)
	g:AddCard(c)
	aux.CardAddedBySkill:AddCard(c)
	Duel.SendtoGrave(g,REASON_RULE)
	e:Reset()
end