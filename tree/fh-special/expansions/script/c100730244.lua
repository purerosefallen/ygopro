--高速决斗技能-命运推进
Duel.LoadScript("speed_duel_common.lua")
function c100730244.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730244.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730244.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_DRAW)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetOperation(c100730244.op)
	Duel.RegisterEffect(e1,tp)
	e:Reset()
end
function c100730244.op(e,tp)
	Duel.Hint(HINT_CARD,1-tp,100730244)
	local g=Duel.GetMatchingGroup(c100730244.filter,tp,LOCATION_MZONE,0,nil)
	if g:GetCount()==0 then return end
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(tc)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetValue(1)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
		local g2=Duel.SelectMatchingCard(tp,c100730244.mfilter,tp,LOCATION_DECK+LOCATION_REMOVED,0,0,1,nil)
		if g2:GetCount()==0 then return end
		local qc=g2:GetFirst()
		if not qc then return end
		Duel.SendtoHand(qc,tp,REASON_RULE)
	end
end
function c100730244.filter(c)
	return c:IsType(TYPE_MONSTER) and c:IsFaceup() and c:IsSetCard(0x31)
end
function c100730244.mfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsRace(RACE_SPELLCASTER) and c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsLevel(1)
end