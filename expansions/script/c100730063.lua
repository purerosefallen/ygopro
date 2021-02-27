--高速决斗技能-逆转的命运
Duel.LoadScript("speed_duel_common.lua")
function c100730063.initial_effect(c)
	aux.SpeedDuelAtMainPhaseNoCountLimit(c,c100730063.skill,c100730063.con,aux.Stringid(100730063,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730063.filter(c)
	return c:IsFaceup() and c:GetFlagEffect(36690018)~=0
end

function c100730063.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730063.filter,tp,LOCATION_MZONE,0,1,nil)
end

function c100730063.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730063)

	local g=Duel.SelectMatchingCard(tp,c100730063.filter,tp,LOCATION_MZONE,0,1,1,nil)
	local tc=g:GetFirst()
	local val=tc:GetFlagEffectLabel(36690018)
	tc:SetFlagEffectLabel(36690018,1-val)
end