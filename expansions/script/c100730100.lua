--高速决斗技能-天赐的宝牌
Duel.LoadScript("speed_duel_common.lua")
function c100730100.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730100.skill,c100730100.con,aux.Stringid(100730100,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730100.Isgod(c)
	return c:IsOriginalCodeRule(10000020) and c:IsFaceup()
end

function c100730100.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730100.Isgod,tp,LOCATION_MZONE,0,1,nil)
		and Duel.GetMZoneCount(tp)>-1
end
function c100730100.skill(e,tp)
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	aux.SpeedDuelSendToDeckWithExile(tp,g)
	local g1=Duel.GetFieldGroup(1-tp,LOCATION_HAND,0)
	aux.SpeedDuelSendToDeckWithExile(1-tp,g1)
	local g2=Duel.GetDecktopGroup(tp,6)
	aux.SpeedDuelSendToHandWithExile(tp,g2)
	local g3=Duel.GetDecktopGroup(1-tp,6)
	aux.SpeedDuelSendToHandWithExile(1-tp,g3)
end